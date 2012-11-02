define rvm::gem( $ensure=present ){
  if $title =~ /^(.+)@((?:.+)?)\/(.+)$/ {
    $rubyver = $1
    $gemset = $2
    $gem = $3
  } else {
    fail( "defined resource rvm::gem must be defined as ruby-<version>@<gemset>/<gemname> (gemset is optional). You have specified ${title}" )
  }

  rvm_gem{ $title:
    name => $title,
    ensure => $ensure,
    require => $gemset ? {
        /^.+$/ => Rvm_gemset["${rubyver}@${gemset}"],
        default => Rvm_system_ruby[$rubyver],
      },
  }
}
