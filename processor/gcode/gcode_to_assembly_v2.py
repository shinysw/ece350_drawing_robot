import re
import math

    # assign step_x_dir = reg19_read;
    # assign step_y_dir = reg20_read;
    # assign step_x_speed = reg21_read;
    # assign step_y_speed = reg22_read;

# square:
#     nop
#     nop
#     nop
#     nop
#     nop
#     addi $r19, $0, 1
#     addi $r21, $0, 1
#     stall $0, $0, 10

#     addi $r19, $0, 0
#     addi $r21, $0, 0

#     addi $r20, $0, 1
#     addi $r22, $0, 1
#     stall $0, $0, 10

#     addi $r20, $0, 0
#     addi $r22, $0, 0

#     addi $r19, $0, -1
#     addi $r21, $0, 1
#     stall $0, $0, 10

#     addi $r19, $0, 0
#     addi $r21, $0, 0

#     addi $r20, $0, -1
#     addi $r22, $0, 1
#     stall $0, $0, 10
#     addi $r20, $0, 0
#     addi $r22, $0, 0

#     # Reset the input
#     addi $r8, $0, 0
#     j       main2           # jump to main2

speed = 30000
freq = 100e6


move_x = "addi $r21, $0, "
stop_x = "addi $r21, $0, 0"

move_y = "addi $r22, $0, "
stop_y = "addi $r22, $0, 0"

stall = "stall "

neg_x = "addi $r19, $0, 0"
pos_x = "addi $r19, $0, 1"

neg_y = "addi $r20, $0, 0"
pos_y = "addi $r20, $0, 1"
# step_x_dir = reg19_read;
# step_y_dir = reg20_read;
# step_x_speed = reg21_read;
# step_y_speed = reg22_read;


def parse_g1_command(command, current_x, current_y):
    x_match = re.search(r'X(-?\d+(\.\d+)?)', command)
    y_match = re.search(r'Y(-?\d+(\.\d+)?)', command)

    #new_position = current_position.copy()

    if x_match:
        new_x = float(x_match.group(1))
    if y_match:
        new_y = float(y_match.group(1))

    dx = new_x - current_x
    dy = new_y - current_y

    da = dx + dy
    db = dx - dy

    #print(dx, dy, da, db)
    
    distance = float(math.sqrt(da**2 + db**2))
    if (distance == 0):
        scaling_factor = 0
    else:        
        scaling_factor = float(speed / distance)

    speed_x = scaling_factor * da
    speed_y = scaling_factor * db

    # distance = float(math.sqrt(dx**2 + dy**2))
    # scaling_factor = float(speed / distance)

    # speed_x = scaling_factor * dx
    # speed_y = scaling_factor * dy

    # time_x = dx / speed_x
    # time_y = dy / speed_y
    time = distance / speed
    clock_delay =  time * 100_000_000

    #print((speed_y))

    #print(da, db)

    if (da >= 0):
        print(pos_x)
    else:
        print(neg_x)

    if (db >= 0):
        print(pos_y)
    else:
        print(neg_y)

    print(f"{move_x}{abs(math.floor(speed_x))}")

    print(f"{move_y}{abs(math.floor(speed_y))}")

    print(f"{stall}{math.floor(clock_delay)}")
    
    return new_x, new_y


def main():
    filename = "triangle.gcode"
    lines = []

    try:
        with open(filename, 'r') as file:
            for line in file:
                stripped_line = line.strip()
                #print(stripped_line)
                lines.append(stripped_line)
    except FileNotFoundError:
        print(f"File not found: {filename}")
    except Exception as e:
        print(f"Error: {e}")

    #current_position = {'x': 0, 'y': 0}
    currX = 0
    currY = 0
    #print("\nG1 Commands:")
    for line in lines:
        if line.startswith('G1'):
            newX, newY = parse_g1_command(line, currX, currY)
            #print(f"Line: {line}, Delta X: {delta_x}, Delta Y: {delta_y}")
            # current_position = new_position
            currX = newX
            currY = newY

    print(stop_x)
    print(stop_y)

if __name__ == "__main__":
    main()
