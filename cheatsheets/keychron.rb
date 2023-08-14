cheatsheet do
  title 'Keychron Key Combinations' # Will be displayed by Dash in the docset list
  docset_file_name 'keychron'       # Used for the filename of the docset
  keyword 'keychron'                # Used as the initial search keyword (listed in Preferences > Docsets)

  introduction 'Key Combinations for Keychron K2/K3'  # Optional, can contain Markdown or HTML

  # A cheat sheet must consist of categories
  category do
    id 'Backlight'

    entry do
      command 'fn + -'
      name 'RGB speed decrease'
    end

    entry do
      command 'fn + ='
      name 'RGB speed increase'
    end

    entry do
      command 'fn + Light Effect'
      name 'Toggle backlight'
    end

    entry do
      command 'fn + Arrow Right'
      command 'fn + Arrow Left'
      name 'Change the backlight colour'
    end

    entry do
      command 'fn + L + Light Effect'
      name 'Lock / unlock the backlight effect'
      notes 'Long press for 3s'
    end
  end

  category do
    id 'Bluetooth'

    entry do
      command 'fn + 1'
      name 'Bluetooth device #1'
      notes 'Long press for 3s for pairing mode'
    end

    entry do
      command 'fn + 2'
      name 'Bluetooth device #2'
      notes 'Long press for 3s for pairing mode'
    end

    entry do
      command 'fn + 3'
      name 'Bluetooth device #3'
      notes 'Long press for 3s for pairing mode'
    end
  end

  category do
    id 'Auto Sleep'

    entry do
      command 'fn + S + O'
      name 'Disable / enable the auto sleep mode'
      notes 'Long press for 3s'
    end

    entry do
      command 'fn + S + L + R'
      name 'Auto sleep in 10 minutes without typing'
      notes 'Long press for 3s'
    end

    entry do
      command 'fn + S + L + T'
      name 'Auto sleep in 20 minutes without typing'
      notes 'Long press for 3s'
    end

    entry do
      command 'fn + S + L + Y'
      name 'Auto sleep in 30 minutes without typing'
      notes 'Long press for 3s'
    end
  end

  category do
    id 'Mac Only'

    entry do
      command 'fn + K + C'
      name 'Switch between function keys and multimedia keys (F5 & F6 only)'
      notes 'Mac mode, long press for 3s'
    end
  end

  category do
    id 'Windows Only'

    entry do
      command 'fn + X + L'
      name 'Switch between function Keys and multimedia keys (F1 - F12)'
      notes 'Windows mode, long press for 3s'
    end

    entry do
      command 'fn + Windows'
      name 'Lock / unlock the windows key'
      notes 'Windows mode, long press for 3s'
    end
  end

  category do
    id 'Misc'

    entry do
      command 'fn + Delete'
      name 'Delete/Insert'
    end

    entry do
      command 'fn + I + D'
      name 'Switch between the delete key and the insert key'
      notes 'Long press for 3s'
    end

    entry do
      command 'fn + B'
      name 'Battery Level'
      notes <<-'END'
        - Backlight red = 0~30% power
        - Backlight blue = 30%~70% power
        - Backlight green = 70%~100% power
      END
    end
  end
end
