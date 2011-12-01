# inherit from utils::base to get resource defaults.
class utils::zip inherits utils::base {

  package{'zip':}
  package {'unzip':}

}
