{ self, config, ... }:
let
  ports = import ../misc/service-ports.nix;
  oauth2-config = ''
    auth_request /oauth2/auth;
    error_page 401 = /oauth2/sign_in;
    # pass information via X-User and X-Email headers to backend,
    # requires running with --set-xauthrequest flag
    auth_request_set $user   $upstream_http_x_auth_request_user;
    auth_request_set $email  $upstream_http_x_auth_request_email;
    proxy_set_header X-User  $user;
    proxy_set_header X-Email $email;
    # if you enabled --cookie-refresh, this is needed for it to work with auth_request
    auth_request_set $auth_cookie $upstream_http_set_cookie;
    add_header Set-Cookie $auth_cookie;
  '';
in {

  services.nginx.virtualHosts."polycule.constellation.moe" = {
    root = self.inputs.constellation-moe;
    enableACME = true;
    addSSL = true;
    extraConfig = ''
      # Set for whole server.
      ${oauth2-config}
    '';

    locations."/oauth2/".extraConfig = ''
      auth_request off;
    '';

    locations."/oauth2/auth".extraConfig = ''
      auth_request off;
    '';

    locations."/stream/" = {
      proxyPass = "http://127.0.0.1:${toString ports.vdo-ninja}/";
      proxyWebsockets = true;
      extraConfig = ''
        add_header Access-Control-Allow-Origin *;
      '';
    };

    locations."/jellyfin".extraConfig = ''
      return 302 $scheme://$host/jellyfin/;
    '';

    locations."/jellyfin/".extraConfig = ''
      # https://jellyfin.org/docs/general/networking/nginx/
      proxy_pass http://127.0.0.1:${toString ports.jellyfin-http}/jellyfin/;
      proxy_pass_request_headers on;
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header X-Forwarded-Proto $scheme;
      proxy_set_header X-Forwarded-Host $http_host;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection $http_connection;
      proxy_buffering off;
    '';

    locations."~* ^/Videos/(.*)/(?!live)".extraConfig = ''
      # https://jellyfin.org/docs/general/networking/nginx/
      slice 2m;
      proxy_cache jellyfin-videos;
      proxy_cache_valid 200 206 301 302 30d;
      proxy_ignore_headers Expires Cache-Control Set-Cookie X-Accel-Expires;
      proxy_cache_use_stale error timeout invalid_header updating http_500 http_502 http_503 http_504;
      proxy_connect_timeout 15s;
      proxy_http_version 1.1;
      proxy_set_header Connection "";
      proxy_set_header Range $slice_range;
      proxy_cache_lock on;
      proxy_cache_lock_age 60s;
      proxy_pass http://127.0.0.1:${toString ports.jellyfin-http};
      proxy_cache_key "jellyvideo$uri?MediaSourceId=$arg_MediaSourceId&VideoCodec=$arg_VideoCodec&AudioCodec=$arg_AudioCodec&AudioStreamIndex=$arg_AudioStreamIndex&VideoBitrate=$arg_VideoBitrate&AudioBitrate=$arg_AudioBitrate&SubtitleMethod=$arg_SubtitleMethod&TranscodingMaxAudioChannels=$arg_TranscodingMaxAudioChannels&RequireAvc=$arg_RequireAvc&SegmentContainer=$arg_SegmentContainer&MinSegments=$arg_MinSegments&BreakOnNonKeyFrames=$arg_BreakOnNonKeyFrames&h264-profile=$h264Profile&h264-level=$h264Level&slicerange=$slice_range";
    '';
  };

  services.nginx.appendHttpConfig = ''
    # https://jellyfin.org/docs/general/networking/nginx/
    proxy_cache_path  /var/cache/nginx/jellyfin-videos levels=1:2 keys_zone=jellyfin-videos:100m inactive=90d max_size=35000m;
    map $request_uri $h264Level { ~(h264-level=)(.+?)& $2; }
    map $request_uri $h264Profile { ~(h264-profile=)(.+?)& $2; }
  '';

  systemd.tmpfiles.settings."10-nginx.conf" = {
    "/var/cache/nginx/jellyfin-videos".d = {
      user = config.services.nginx.user;
      group = config.services.nginx.group;
      mode = "0777";
    };
  };
  
}