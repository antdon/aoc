#include <unordered_set>
#include <print>
#include <iostream>
#include <vector>
#include <utility>
#include <algorithm>
#include <ranges>

using ull = unsigned long long;

struct PuzzleInput {
    std::vector<std::pair<ull,ull>> freshRanges;
    std::vector<ull> ingredients;
};

PuzzleInput parseInput() {
    auto input = PuzzleInput{};
    ull minFresh;
    ull maxFresh;
    char colon;
    while (std::cin.peek() != '\n' && std::cin >> minFresh >> colon >> maxFresh) {
	std::cin.ignore();
	input.freshRanges.push_back({minFresh, maxFresh});
    }

    ull ingredientId;
    while (std::cin >> ingredientId) {
	input.ingredients.push_back(ingredientId);
    }
    return input;
}

bool fresh(std::pair<ull, ull> range, ull ingredient) {
    return range.first <= ingredient && range.second >= ingredient;
}

int part1(PuzzleInput input) {
    // filter if not within any range
    std::erase_if(input.ingredients, [&ranges = input.freshRanges](auto ingredient) {
	return std::ranges::all_of(ranges, [&ingredient](auto range) { return !fresh(range, ingredient); });
    });
  return input.ingredients.size();
}

bool touching(const std::pair<ull, ull> &range1,
              const std::pair<ull, ull> &range2) {
    // note: range1.first must be less than or equal to range2.first
    return range1.second >= range2.first;
}

ull part2P(PuzzleInput &input) {
  auto r = 1;
  auto l = 0;
  std::ranges::sort(input.freshRanges, [](auto a, auto b) {
      return a.first < b.first;
  });
  auto ranges = input.freshRanges;
  auto newRanges = std::vector<std::pair<ull,ull>>{};
  while (r < ranges.size()) {
    auto rightRange = ranges[r];
    auto previousRange = ranges[r-1];
    auto leftRange = ranges[l];
    if (r == ranges.size() - 1) {
      if (touching(previousRange, rightRange)) {
	  newRanges.push_back({leftRange.first, rightRange.second});
      } else {
	  newRanges.push_back({leftRange.first, previousRange.second});
	  newRanges.push_back(rightRange);
      }
      break;
    }
    if (!touching(previousRange, rightRange)){
	newRanges.push_back({leftRange.first, previousRange.second});
	l = r;
    }
    ++r;
  }
  std::print("{}\n", newRanges);
  return std::ranges::fold_left(newRanges, 0ull, [](auto accumulator, auto range) {
      return accumulator += range.second - range.first + 1;
  });
}

ull part2(PuzzleInput &input) {
  std::ranges::sort(input.freshRanges, [](auto a, auto b) {
      return a.first < b.first;
  });
  auto ranges = input.freshRanges;
  auto newRanges = std::vector<std::pair<ull, ull>>{ranges[0]};

  for (const auto &range : ranges | std::views::drop(1)) {
      auto previousRange = newRanges.back();
      if (touching(previousRange, range)) {
	  newRanges.rbegin()->second = std::ranges::max(previousRange.second, range.second);
      } else {
	  newRanges.push_back(range);
      }
  }
  return std::ranges::fold_left(newRanges, 0ull, [](auto accumulator, auto range) {
      return accumulator += range.second - range.first + 1;
  });


      
}

int main() {
  auto input = parseInput();
  // std::print("{}\n", input.freshRanges);
  // std::print("{}\n", input.ingredients);
  std::cout << input.ingredients.size() << std::endl;
  std::cout << part1(input) << std::endl;
  std::cout << part2(input) << std::endl;


  
  
  return 0;
}
