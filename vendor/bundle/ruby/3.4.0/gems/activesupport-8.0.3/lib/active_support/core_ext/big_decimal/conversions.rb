require"bigdecimal";require"bigdecimal/util";module ActiveSupport;module BigDecimalWithDefaultFormat
def to_s(format="F")super(format);end;end;end;BigDecimal.prepend(ActiveSupport::BigDecimalWithDefaultFormat)
