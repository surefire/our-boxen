class people::andrewgarner {
  include alfred
  include appcleaner
  include dropbox
  include wget
  include zsh

  include osx::finder::empty_trash_securely
  include osx::finder::unhide_library
  include osx::global::enable_keyboard_control_access
  include osx::global::expand_print_dialog
  include osx::global::expand_save_dialog
  include osx::no_network_dsstores
  include osx::software_update

  osx::recovery_message { 'If this computer is found, please call +44 7971 232140': }

  $home           = "/Users/${::boxen_user}"
  $dotfiles       = "${home}/.dotfiles"
  $tomorrow_theme = "${boxen::config::srcdir}/tomorrow-theme"

  class { 'osx::dock::position':
    position => 'right'
  }

  class { 'osx::dock::icon_size':
    size => 36
  }

  class { 'osx::global::key_repeat_delay':
    delay => 200
  }

  class { 'osx::global::key_repeat_rate':
    rate => 400
  }

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

  }

  repository {

    $dotfiles:
      source => 'andrewgarner/dotfiles';

    $tomorrow_theme:
      source => 'chriskempson/tomorrow-theme';

    "${home}/.oh-my-zsh":
      source => 'robbyrussell/oh-my-zsh';

  }

  if $::hostname == 'surefire' {
    include cloudapp
    include emacs
    include evernote
    include firefox
    include gitx::dev
    include handbrake
    include heroku
    include istatmenus
    include iterm2::stable
    include python
    include sequel_pro
    include skype
    include spotify
    include tmux
    include vagrant
    include virtualbox
    include vlc

    include osx::dock::hide_indicator_lights

    include nodejs::v0_6
    include nodejs::v0_8
    include nodejs::v0_10

    class {

      'intellij':
        edition => 'ultimate',
        version => '13';

    }

    file {

      "${home}/Library/Application Support/Sublime Text 3/Packages/User":
        ensure => link,
        target => "${home}/Dropbox/Preferences/Sublime Text 3/Packages/User";

      "${home}/Library/Preferences/IntelliJIdea13/colors/Tomorrow Night Eighties.xml":
        ensure  => link,
        target  => "${$tomorrow_theme}/Jetbrains/colors/Tomorrow Night Eighties.xml",
        require => Repository[$tomorrow_theme];

      "${boxen::config::bindir}/subl":
        ensure => link,
        target => "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl";

    }

    heroku::plugin {

      'accounts':
        source => 'ddollar/heroku-accounts'

    }

    nodejs::module {

      'iectrl':
        node_version => 'v0.10'

    }

  }
}
