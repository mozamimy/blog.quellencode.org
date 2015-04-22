require "sdbm"

class Klass
  def initialize(db_path)
    @sdb = SDBM.new(db_path)
  end

  def method1
    @sdb["hoge"] = "HOGE"
  end

  def method2
    @sdb["hoge"]
  end
end

klass = Klass.new("test.sdb")
klass.method1
p klass.method2
