{ ... }:
{

  environment.etc
    ."pipewire/pipewire.conf.d/99-virtual-sink.conf"
    .source = ./99-virtual-sink.conf;
    
}