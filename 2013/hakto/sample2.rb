require "sdbm"

class Klass
  def initialize(db_path)
    @db_path = db_path
  end

  def method1
    SDBM.open(@db_path) do |dbm|
      dbm["hoge"] = "HOGE"
    end
  end

  def method2
    SDBM.open(@db_path) do |dbm|
      dbm["hoge"]
    end
  end
end

klass = Klass.new("test.sdb")
klass.method1
p klass.method2
