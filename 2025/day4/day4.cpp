#include <print>
#include <ranges>
#include <iostream>
#include <vector>
#include <string>
#include <utility>
#include <algorithm>

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

std::vector<std::string> removeTpCopy(const std::vector<std::string> &map, const std::pair<int,int> pos) {
    auto newMap = map;
    newMap[pos.first][pos.second] = '.';
    return newMap;
}

bool accessibleTP(const std::vector<std::string>& lines, int x, int y) {
	    if (lines[x][y] != '@') {
		return false;
	    }
	    auto neighs = neighbours(lines, {x,y});
	    auto tpCount = std::ranges::count_if(neighs, [](auto potentialTP) { return potentialTP == '@'; });
	    // std::cout << x << " " << y << " " << tpCount << std::endl;
	    // std::print("{}\n", neighs);
            if (tpCount >= 4) {
		return false;
	    }
	    return true;
}

auto part2(std::vector<std::string> &map) -> int {
    // we can either take the tp or leave it
    for (const auto x : std::views::iota(0uz, map.size())) {
	auto line = map[x];
	for (auto y : std::views::iota(0uz, line.size())){
	    if (accessibleTP(map, x, y)) {
		auto removedMap = removeTpCopy(map, {x,y});

		return std::max(part2(removedMap) + 1, part2(map));
	    }
        }
    }
    return 0;
}


int main() {
    auto lines = parseInput();
    auto part1 = 0;
    for (const auto x : std::views::iota(0uz, lines.size())) {
	auto line = lines[x];
	for (auto y : std::views::iota(0uz, line.size())){
          if (accessibleTP(lines, x, y)) {
	      part1 += 1;
	  }
	}
    }
    std::cout << part1 << std::endl;
    auto part2_ = part2(lines);
    std::cout << part2_ << std::endl;



    return 0;
}
