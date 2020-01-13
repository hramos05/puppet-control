## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

## Node Definitions ##
node default {
  # Load classes using Hiera
  lookup('classes', {merge => unique}).include

  # DEBUG Hiera YAML
  $hiera_yaml_names = lookup('hiera_yaml_name',Array,'unique',[])
  $hiera_yaml_names.each | $name | {
    notify {"Loaded hiera YAML: ${$name}":
      loglevel => debug,
    }
  }
}
