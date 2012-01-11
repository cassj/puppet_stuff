class wordpress {
  include apache,mysql,php,php::mysql,php::apc
#, php::intl
  include wordpress::params
}
