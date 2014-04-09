# puppet-module-hponcfg

This module manages the HP Online Configuration utility (hponcfg).

===

# Compatibility

Systems with HP iLO.

===

# Parameters

package_name
------------
String or array of packages

- *Default*: 'hponcfg'

package_ensure
--------------
Ensure value for the packges

- *Default*: 'present'

xmlfiles
--------
Hash of hponcfg::xmlfile resources. See documentation below.

- *Default*: undef

===

# Define: hponcfg::xmlfile

Creates XML files for hponcfg configuration. $content or $source must be passed.

# Parameters

path
----
XML file path

- *Default*: undef

owner
-----
XML file's owner

- *Default*: 'root'

group
-----
XML file's group

- *Default*: 'root'

mode
----
XML file's mode

- *Default*: '0644'

content
-------
String with XML file's content

- *Default*: undef

source
------
XML file's source

- *Default*: undef

