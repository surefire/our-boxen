class people::andrewgarner {
  include alfred
  include emacs
  include gitx::dev
  include iterm2::stable
  include skype
  include zsh

  include osx::finder::empty_trash_securely

  include osx::global::enable_keyboard_control_access
  include osx::global::key_repeat_rate

  include osx::no_network_dsstores
  include osx::software_update

  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/.dotfiles"

  file {

    "${home}/.profile":
      ensure  => link,
      target  => "${dotfiles}/.profile",
      require => Repository[$dotfiles];

    "${home}/.zshrc":
      ensure  => link,
      target  => "${dotfiles}/.zshrc",
      require => Repository[$dotfiles];

  }

  repository {

    $dotfiles:
      source   => 'andrewgarner/dotfiles',
      provider => 'git';

    "${home}/.oh-my-zsh":
      source   => 'robbyrussell/oh-my-zsh',
      provider => 'git';

  }
}
