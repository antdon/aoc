#include <iostream>
#include <string_view>
#include <ranges>
#include <string>
#include <vector>
#include <charconv>
#include <algorithm>
#include <array>

struct Range {
    uint64_t lower;
    uint64_t upper;
};

std::vector<Range> parseInput() {
    std::string line;
    std::cin >> line;
    return line
	| std::views::split(',')
	| std::views::transform([](auto rawRange) -> Range {
	    auto rangeElements = (rawRange | std::views::split('-')).begin();
	    auto lower = *rangeElements;
	    ++rangeElements;
	    auto upper = *rangeElements;
	    uint64_t lowerVal, upperVal;
	    std::from_chars(lower.data(), lower.data() + lower.size(), lowerVal);
	    std::from_chars(upper.data(), upper.data() + upper.size(), upperVal);
	    return { lowerVal, upperVal };
	})
	| std::ranges::to<std::vector<Range>>();
}

bool isRepetition(const std::string& value, int splits) {
  if (value.size() % 2 != 0) {
      return false;
  }
  auto sv = std::string_view(value);
  auto size = value.size() / splits;
  auto first = sv.substr(0, size);
  for (const auto& start : std::views::iota(0uz, value.size() - size + 1)) {
      if (sv.substr(start, size) != first) {
	  return false;
      }
  }
  return true;
}


int main() {
    auto ranges = parseInput();
    uint64_t total = 0;
    for (const auto& range : ranges) {
	for (const auto& val : std::views::iota(range.lower,range.upper+1)) {
	    auto digits = std::to_string(val);
            if (isRepetition(digits, 2)) {
		total += val;
	    }
	}
    }
    std::cout << total << std::endl;
    
}

    

