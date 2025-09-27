class Array;def extract!;return to_enum(:extract!){size} unless block_given?;extracted_elements=[];reject! do |element|extracted_elements<<element if yield(element);end;extracted_elements;end;end
