
module HashieClone

  #
  # Uses Structs
  #
  def to_struct(object)
    result = object
    case
    when result.is_a?(Hash)
      result = result.dup
      result.each do |key, value|
        result[key] = to_struct(value)
      end
      result = ::Struct.new( *(k=result.keys)).new( *result.values_at(*k) )
    when result.is_a?(Array)
      result = result.map { |r| to_struct(r) }
    else
    end
    result
  end
end
