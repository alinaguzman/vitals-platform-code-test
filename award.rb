module Award

  CLASS_NAMES = {
      'NORMAL ITEM' => 'NormalAward',
      'Blue First' => 'BlueFirst',
      'Blue Distinction Plus' => 'BluePlus',
      'Blue Compare' => 'BlueCompare'
  }

  def self.new(name, expires_in, quality)
    classname = CLASS_NAMES[name]
    Object.const_get(classname).new(name, expires_in, quality)
  end

end

class NormalAward

  attr_accessor :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @expires_in = expires_in
    @quality = quality
  end

  def calculate_quality
    if @expires_in > 0
      @quality = [@quality -= 1, 0].max
    else
      @quality = [@quality -= 2, 0].max
    end
  end

  def update_expires
    @expires_in -= 1
  end

end

class BlueFirst < NormalAward

  def calculate_quality
    if @expires_in > 0
      @quality = [@quality += 1, 50].min
    else
      @quality = [@quality += 2, 50].min
    end
  end

end

class BluePlus < NormalAward

  def calculate_quality
    @quality = 80
  end

  def update_expires
    nil
  end

end

class BlueCompare < NormalAward

  def calculate_quality
    if @expires_in <= 0
      @quality = 0
    elsif @expires_in >= 11
      @quality = [@quality += 1, 50].min
    elsif @expires_in <= 10 && @expires_in > 5
      @quality = [@quality += 2, 50].min
    elsif @expires_in < 6
      @quality = [@quality += 3, 50].min
    end
  end

end
