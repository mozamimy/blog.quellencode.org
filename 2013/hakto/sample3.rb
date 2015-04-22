require "hakto/safe_sdbm"

class Klass
  def initialize(db_path)
    @dbm = Hakto::SafeSDBM.new(db_path)
  end

  def method1
    @dbm["hoge"] = "HOGE"
  end

  def method2
    @dbm["hoge"]
  end
end

klass = Klass.new("test.sdb")
klass.method1
p klass.method2
