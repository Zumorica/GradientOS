{

  ssh = 22;

  # nginx
  gradient-moe = 80;
  gradient-moe-secure = 443;
  oauth2-proxy = 4180;

  # wireguard
  gradientnet = 1194;
  lilynet = 1195;
  slugcatnet = 1196;

  # media stack
  jellyfin-http = 8096;
  jellyfin-https = 8920;
  jellyfin-service-discovery = 1900;
  jellyfin-client-discovery = 7359;
  radarr = 7878;
  sonarr = 8989;
  jackett = 9117;
  bazarr = 6767;
  deluge-web = 8112;
  deluge-daemon = 58846;
  deluge-listen = [ 6881 6891 ];

  # misc
  redis-oauth2 = 6380;
  trilium = 8081;
  
  # game servers
  project-zomboid = 16261;
  project-zomboid-direct = 16262;
  project-zomboid-steam-1 = 21971;
  project-zomboid-steam-2 = 21972;
}