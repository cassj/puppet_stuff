# see https://github.com/gitlabhq/gitlabhq/blob/master/doc/install/installation.md

# we're using mysql. should probably have an option to use postgres instead.
class git::gitlab($user='git',
                  $user_home='/home/git', 
                  $gitlab_shell_config_file='puppet:///files/gitlab-shell-config.yml',
                  $mysql_config_file='puppet:///modules/mysql/my.cnf.debian',
                  $mysql_root_pass,
                  $mysql_user = 'gitlab',
                  $mysql_user_pass,
                  $mysql_database = 'gitlabhq_production',
                  $gitlab_config_file = 'puppet:///files/gitlab-config.yml',
                  $gitlab_unicorn_config_file = 'puppet:///files/gitlab-unicorn-config.rb',
                  $gitlab_git_config_file = 'puppet:///files/gitlab-git-config',
                  $gitlab_database_config_file = 'puppet:///files/gitlab-database-config.yml',
                  $gitlab_init_file = 'puppet:///files/gitlab-init-file',
                  $gitlab_puma_config_file = 'puppet:///files/gitlab-puma-config.rb',
                  $gitlab_nginx_config_file = 'puppet:///files/gitlab-nginx-config'
                  
      
) {


  # create a git user and group
  group{$user:
    ensure => present
  }
  user{$user:
    ensure     => present,
    shell      => '/bin/bash',
    gid        => $user,
    managehome => true,
    home       => $user_home,
    require    => Group[$user]
  }

  class {'git::gitlab::shell':
    config_file => $gitlab_shell_config_file
  }

  class {'git::gitlab::database':
    mysql_config_file => $mysql_config_file,
    mysql_root_pass   => $mysql_root_pass,
    mysql_user        => $mysql_user,
    mysql_user_pass   => $mysql_user_pass,
    mysql_database    => $mysql_database
  }

  class {'git::gitlab::gitlab':
    gitlab_config_file => $gitlab_config_file,
    gitlab_unicorn_config_file => $gitlab_unicorn_config_file,
    gitlab_git_config_file => $gitlab_git_config_file,
    gitlab_database_config_file => $gitlab_database_config_file,
    gitlab_init_file => $gitlab_init_file,
    gitlab_puma_config_file => $gitlab_puma_config_file,
    gitlab_nginx_config_file => $gitlab_nginx_config_file
  }

   include git::gitlab::service

 
}
