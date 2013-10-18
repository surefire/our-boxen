class people::andrewgarner {
  include alfred
  include emacs

  include osx::finder::empty_trash_securely

  include osx::global::enable_keyboard_control_access
  include osx::global::key_repeat_rate

  include osx::no_network_dsstores
  include osx::software_update

  $home = "/Users/${::boxen_user}"
}
