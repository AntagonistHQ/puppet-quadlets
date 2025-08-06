# @summary Main class for setting quadlet support
#
# @param socket_enable Should podman.socket be started and enabled
# @param create_quadlet_dir Should the directory for storing quadlet files be created.
#
# @param selinux_container_manage_cgroup
#   If SELinux is enabled and this is true, set SELinux boolean
#   'container_manage_cgroup' to true. Required if you want to run containers in
#   systemd mode
#   If SELinux is not enabled on system this does nothing.
#
# @param purge_quadlet_dir
#   Should the directory for storing quadlet files be purged. This has no effect
#   unless create_quadlet_dir is set to true.
#
# @example Set up Podman for quadlets
#   include quadlets
#
# @see https://github.com/containers/podman/blob/main/docs/source/markdown/options/systemd.md container_manage_cgroup
class quadlets (
  Boolean $selinux_container_manage_cgroup = false,
  Boolean $socket_enable = true,
  Boolean $create_quadlet_dir = false,
  Boolean $purge_quadlet_dir = false,
) {
  $quadlet_dir = '/etc/containers/systemd'
  $quadlet_user_dir = '.config/containers/systemd'

  contain quadlets::install
  contain quadlets::config
  contain quadlets::service

  Class['quadlets::install'] -> Class['quadlets::config'] -> Class['quadlets::service']
}
