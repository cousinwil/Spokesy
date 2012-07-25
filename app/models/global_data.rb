class GlobalData < ActiveRecord::Base
  attr_accessible :name, :value

  def self.format_name(name)
    if name
      array = name.split
      return array[0] + ' ' + array[-1][0, 1] + '.'
    end
    return name
  end
end
