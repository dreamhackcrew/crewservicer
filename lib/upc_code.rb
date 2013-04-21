class UpcCode
	def initialize(code)
		@code = code
	end

	def to_i
		@code[0..-2].to_i
	end
end
