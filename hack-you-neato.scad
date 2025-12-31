
$fn = 150;

clearance = 0.2;
border = [1.5, 1.5, 1.5];

CD4051 = [19, 29, 1.5];
CD4051HoleRadius = 2;
CD4051HoleOffset = 1.2;

XIAO = [18, 23, 1];

groove = [3, 0, 1];

notchWidth = 9;

gapWidth = 8;

height = max(CD4051.z, XIAO.z) + groove.z + border.z;

difference() {
    // Base plate
    cube([
        border.x + clearance + CD4051.x + clearance + gapWidth + clearance + XIAO.x + clearance + border.x,
        border.y + clearance + CD4051.y + clearance + border.y,
        height
    ]);

    // Extra material cutout
    translate([
        -0.01,
        border.y + clearance + XIAO.y + clearance + border.y,
        -0.01,
    ])
    cube([
        border.x + clearance + XIAO.x + clearance + gapWidth - border.x,
        border.y + (CD4051.y - XIAO.y),
        height + 0.02
    ]);

    // CD4051 inset
    color("purple") {    
        translate([
            border.x + clearance + XIAO.x + clearance + gapWidth,
            border.y,
            height - CD4051.z + 0.01])
        BoardInset(CD4051, clearance, groove);
    }

    // XIAO inset
    color("darkgray") {
        translate([
            border.x,
            border.y,
            height - XIAO.z + 0.01])
        BoardInset(XIAO, clearance, groove);
    }

    // Back engraving
    translate([42, 15, -0.01])
    linear_extrude(height=1)
    rotate([0, 180, 0]) {
        text("Hack you,", font="Jersey 25", size=7);
        translate([0, -8, 0])
        text("Neato!", font="Jersey 25", size=7);
    }
}

// Peg 1 for CD4051
translate([
    border.x + clearance + XIAO.x + clearance + gapWidth + clearance + CD4051.x / 2,
    border.x + clearance + CD4051HoleOffset + CD4051HoleRadius,
    0])
cylinder(h=height, r=CD4051HoleRadius - clearance);

// Peg 2 for CD4051
translate([
    border.x + clearance + XIAO.x + clearance + gapWidth + clearance + CD4051.x / 2,
    border.x + clearance + CD4051.y - (CD4051HoleOffset + CD4051HoleRadius),
    0])
cylinder(h=height, r=CD4051HoleRadius - clearance);

module BoardInset(dimentions, clearance, groove) {
    cube([
        clearance + dimentions.x + clearance,
        clearance + dimentions.y + clearance,
        dimentions.z]);

    // Groove 1
    translate([0, 0, -groove.z + 0.02])
    cube([
        groove.x,
        clearance + dimentions.y + clearance,
        groove.z]);

    // Groove 2
    translate([
        clearance + dimentions.x + clearance - groove.x,
        0,
        -groove.z + 0.02])
    cube([
        groove.x,
        clearance + dimentions.y + clearance,
        groove.z]);
    
    // Notch
    translate([
        dimentions.x / 2 - notchWidth / 2,
        clearance + dimentions.y + clearance - 0.01,
        0.01])
    cube([
        clearance + notchWidth + clearance,
        border.y + 0.02,
        dimentions.z]);

}
