node.default['keycastr'] = {
  'domain' => 'net.stephendeken.keycastr',
  'settings' => {
    'Has been launched' => {
      :key => 'SUHasLaunchedBefore', :value => true, :type => :boolean
    },
    'Command Keys Only' => {
      :key => 'default.commandKeysOnly', :value => true, :type => :boolean
    },
    'Font Size' => {
      :key => 'default.fontSize', :value => 36.1, :type => :float
    },
    'Show Prefs on Launch' => {
      :key => 'alwaysShowPrefs', :value => false, :type => :boolean
    },
    'Window Placement, top right corner' => {
      :key => 'NSWindow Frame KCBezelWindow default.bezelWindow', :value => '2353 1353 200 0 0 0 2560 1418 ', :type => :string
    },
    'Show only in menubar' => {
      :key => 'displayIcon', :value => 1, :type => :integer
    }
  }
}
