#include <iostream>
#include <algorithm>

enum Direction {
    Left,
    Right
};

struct Rotation {
    Direction direction;
    int distance;
};

std::vector<Rotation> parseInput() {
    std::string val;
    auto rotations = std::vector<Rotation>{};
    while (std::cin >> val) {
	Direction direction;
	if (val[0] == 'L') {
	    direction = Left;
	} else {
	    direction = Right;
	}
	rotations.push_back({direction, std::stoi(val.substr(1))});
    }
    return rotations;
}

bool part1Condition(int position, const Rotation rotation){
    if (rotation.direction == Left) {
	position -= rotation.distance;
    } else {
	position += rotation.distance;
    }
    position %= 100;
    return position == 0;
}

int part2Condition(int position, const Rotation& rotation) {
    // there's probs some math way to do this
    auto zeroPasses = 0;
    for (auto i = 0; i < rotation.distance; ++i) {
	if (rotation.direction == Left) {
	    position -= 1;
	} else {
	    position += 1;
	}
        position %= 100;
        if (position < 0) {
	    position += 100;
	}
	    
        if (position == 0) {
	    zeroPasses += 1;
        } 
    }
    return zeroPasses;
}

auto rotate(int &position, const Rotation& rotation) {
    if (rotation.direction == Left) {
	position -= rotation.distance;
    } else {
	position += rotation.distance;
    }
    position %= 100;
    if (position < 0) {
	position += 100;
    }
}

int main() {
    auto rotations = parseInput();
    struct State {
	int position;
        int part1;
	int part2;
    };
    auto result = std::ranges::fold_left(rotations, State{50, 0, 0},
                           [](State accumulator, Rotation &rotation) -> State {
			       int zeroPasses = part2Condition(accumulator.position, rotation);
			       int landedOnZero = part1Condition(accumulator.position, rotation);
			       rotate(accumulator.position, rotation);
			       return {
				   accumulator.position,
				   accumulator.part1 + landedOnZero,
				   accumulator.part2 + zeroPasses
			       };});
    std::cout << "part 1: " << result.part1 << std::endl;
    std::cout << "part 2: " << result.part2 << std::endl;
}


