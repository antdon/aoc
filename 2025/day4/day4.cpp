#include <print>
#include <ranges>
#include <iostream>
#include <vector>
#include <string>
#include <utility>
#include <algorithm>

void printTable(std::vector<std::string>& lines) {
    for (const auto& line : lines) {
	std::cout << line << "\n" << std::endl;
    }
}

std::vector<std::string> parseInput() {
    std::string line;
    auto lines = std::vector<std::string>{};
    while (std::cin >> line) {
	lines.push_back(line);
    }
    return lines;
}

std::vector<char> neighbours(const std::vector<std::string>& map, const std::pair<int,int>& pos) {
    auto neighbourIndexs = std::vector<std::pair<int,int>>{};
    if (pos.first != 0) {
	neighbourIndexs.push_back({pos.first-1, pos.second});
	if (pos.second != 0) {
	    neighbourIndexs.push_back({pos.first-1, pos.second-1});
	}
	if (pos.second != map[0].size() - 1) {
	    neighbourIndexs.push_back({pos.first - 1, pos.second + 1});
	}
    }
    if (pos.first != map.size() - 1) {
	neighbourIndexs.push_back({pos.first + 1, pos.second});
	if (pos.second != 0) {
	    neighbourIndexs.push_back({pos.first + 1, pos.second-1});
	}
	if (pos.second != map[0].size() - 1) {
	    neighbourIndexs.push_back({pos.first + 1, pos.second + 1});
	}
    }
    if (pos.second != 0) {
	neighbourIndexs.push_back({pos.first, pos.second-1});
    }
    if (pos.second != map[0].size() - 1) {
	neighbourIndexs.push_back({pos.first, pos.second + 1});
    }
    return neighbourIndexs
	| std::views::transform([&map](auto index) {
	    auto item = map[index.first][index.second];
	    // std::cout << index.first << " " << index.second << " " << item << std::endl;
	    return item;
	})
	| std::ranges::to<std::vector<char>>();
}

bool accessibleTP(const std::vector<std::string>& lines, int x, int y) {
    if (lines[x][y] != '@') {
	return false;
    }
    auto neighs = neighbours(lines, {x,y});
    auto tpCount = std::ranges::count_if(neighs, [](auto potentialTP) { return potentialTP == '@'; });
    if (tpCount >= 4) {
	return false;
    }
    return true;
}

auto part1(std::vector<std::string> &lines) -> int {
    auto part1 = 0;
    auto removed = std::vector<std::pair<int,int>>{};
    for (const auto x : std::views::iota(0uz, lines.size())) {
	auto line = lines[x];
	for (auto y : std::views::iota(0uz, line.size())){
	    if (accessibleTP(lines, x, y)) {
		part1 += 1;
		removed.push_back({x,y});
	    }
	}
    }
    for (auto [x, y] : removed) {
	lines[x][y] = '.';
    }
    return part1;
}

auto part2(std::vector<std::string> &lines) -> int {
    if (std::ranges::all_of(
	    std::views::iota(0uz, 
			     lines.size()), 
	    [&lines](auto y) {
		auto line = lines[y];
		return std::ranges::all_of(
		    std::views::iota(0uz, 
				     lines.size()),
		    [&line, &lines, y](auto x) {
			return !accessibleTP(lines, x, y);
		    });
	    })) {
      // if none are accessible
	return 0;
    }
    auto val = part1(lines);
    return val + part2(lines);
}


int main() {
    auto lines = parseInput();
    auto part1_ = part1(lines);
    auto part2_ = part2(lines);
    std::cout << part1_ << std::endl;
    std::cout << part1_ + part2_ << std::endl;

    return 0;
}
