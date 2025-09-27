class Range;def sole;if self.begin.nil?||self.end.nil?;raise ActiveSupport::EnumerableCoreExt::SoleItemExpectedError,"infinite range '#{inspect}' cannot represent a sole item";end;super ;end;end
