class people::andrewgarner {
  include alfred
  include appcleaner
  include emacs
  include firefox
  include gitx::dev
  include istatmenus
  include iterm2::stable
  include rubymine
  include skype
  include spotify
  include tmux
  include zsh

  include osx::finder::empty_trash_securely

  include osx::global::enable_keyboard_control_access
  include osx::global::key_repeat_rate

  include osx::no_network_dsstores
  include osx::software_update

  $home     = "/Users/${::boxen_user}"
  $dotfiles = "${home}/.dotfiles"

  file {

    "${home}/.bundle":
      ensure  => link,
      target  => "${dotfiles}/.bundle",
      require => Repository[$dotfiles];

    "${home}/.profile":
      ensure  => link,
      target  => "${dotfiles}/.profile",
      require => Repository[$dotfiles];

    "${home}/.zshrc":
      ensure  => link,
      target  => "${dotfiles}/.zshrc",
      require => Repository[$dotfiles];

    "${home}/Library/Application Support/Sublime Text 3/Packages/User":
      ensure => link,
      target => "${home}/Dropbox/Preferences/Sublime Text 3/Packages/User";

    "${boxen::config::bindir}/subl":
      ensure => link,
      target => "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl";

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
