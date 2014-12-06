class people::andrewgarner {
  include alfred
  include appcleaner
  include atom
  include cloudapp
  include docker
  include dropbox
  include emacs
  include evernote
  include firefox
  include gitx::dev
  include handbrake
  include heroku
  include hub
  include intellij
  include istatmenus
  include iterm2::stable
  include postgresql
  include python
  include sequel_pro
  include skype
  include spotify
  include tmux
  include vagrant
  include virtualbox
  include vlc
  include vmware_fusion
  include wget
  include zsh

  include osx::dock::hide_indicator_lights
  include osx::dock::icon_size
  include osx::dock::position
  include osx::finder::empty_trash_securely
  include osx::finder::enable_quicklook_text_selection
  include osx::finder::unhide_library
  include osx::global::enable_keyboard_control_access
  include osx::global::expand_print_dialog
  include osx::global::expand_save_dialog
  include osx::global::key_repeat_delay
  include osx::global::key_repeat_rate
  include osx::keyboard::capslock_to_control
  include osx::no_network_dsstores
  include osx::software_update

  Git::Config::Global <| title == "core.excludesfile" |> {
    value => '~/.gitignore'
  }

  $home                 = "/Users/${::boxen_user}"
  $config               = "${boxen::config::srcdir}/config"
  $docker_intellij_idea = "${boxen::config::srcdir}/docker-intellij-idea"
  $tomorrow_theme       = "${boxen::config::srcdir}/tomorrow-theme"

  file {

    "${home}/.bundle":
      ensure  => link,
      target  => "${config}/.bundle",
      require => Repository[$config];

    "${home}/.gemrc":
      ensure  => link,
      target  => "${config}/.gemrc",
      require => Repository[$config];

    "${home}/.gitconfig":
      ensure  => link,
      target  => "${config}/.gitconfig",
      require => Repository[$config];

    "${home}/.gitignore":
      ensure  => link,
      target  => "${config}/.gitignore",
      require => Repository[$config];

    "${home}/.guardrc":
      ensure  => link,
      target  => "${config}/.guardrc",
      require => Repository[$config];

    "${home}/.irbrc":
      ensure  => link,
      target  => "${config}/.irbrc",
      require => Repository[$config];

    "${home}/.profile":
      ensure  => link,
      target  => "${config}/.profile",
      require => Repository[$config];

    "${home}/.zshrc":
      ensure  => link,
      target  => "${config}/.zshrc",
      require => Repository[$config];

  }

  osx::recovery_message { 'If this computer is found, please call +44 7971 232140': }

  package {

    ['direnv']:

  }

  repository {

    $config:
      source => 'andrewgarner/config';

    $docker_intellij_idea:
      source => 'masgari/docker-intellij-idea';

    $tomorrow_theme:
      source => 'chriskempson/tomorrow-theme';

    "${home}/.oh-my-zsh":
      source => 'robbyrussell/oh-my-zsh';

  }

  file {

    "${home}/.tmux.conf":
      ensure  => link,
      target  => "${config}/.tmux.conf",
      require => Repository[$config];

    "${home}/Library/Preferences/IntelliJIdea13/colors/Tomorrow Night Eighties.xml":
      ensure  => link,
      target  => "${$tomorrow_theme}/Jetbrains/colors/Tomorrow Night Eighties.xml",
      require => Repository[$tomorrow_theme];

    "${home}/Library/Preferences/IntelliJIdea13/filetypes/Dockerfile.xml":
      ensure  => link,
      target  => "${$docker_intellij_idea}/Dockerfile.xml",
      require => Repository[$docker_intellij_idea];

  }

  heroku::plugin {

    'accounts':
      source => 'ddollar/heroku-accounts'

  }

  nodejs::module {

    ['bower', 'iectrl']:
      node_version => 'v0.10'

  }

  nodejs::version { 'v0.6': }
  nodejs::version { 'v0.8': }
  nodejs::version { 'v0.10': }

  ruby::version { '1.9.3': }
  ruby::version { '2.0.0': }
  ruby::version { '2.1.0': }
  ruby::version { '2.1.1': }
  ruby::version { '2.1.2': }

}
