function [flipped] = flip_to_etalon(original)
N = log2(numel(original));
flipped = rot90(original, 2);
switch N
    case 2
        flipped(:, 1:2) = fliplr(flipped(:, 1:2));
    case 3
        flipped(:, 1:2) = fliplr(flipped(:, 1:2));
    case 4
        flipped(:, 1:2) = fliplr(flipped(:, 1:2));
        flipped(1:2, :) = flipud(flipped(1:2, :));
    case 5
        flipped(:, 1:4) = fliplr(flipped(:, 1:4));
        flipped(:, 3:4) = fliplr(flipped(:, 3:4));
        flipped(:, 5:6) = fliplr(flipped(:, 5:6));
        flipped(1:2, :) = flipud(flipped(1:2, :));
    otherwise
        flipped = 'PASHOL NAHOOI';
end
end