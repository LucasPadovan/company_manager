class RawMaterial < Product

  def self.products_for_select
    RawMaterial.all.map{ |x| [x.name, x.id]}
  end

end
