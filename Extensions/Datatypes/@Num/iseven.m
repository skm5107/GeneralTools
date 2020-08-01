function [tf_all, tf_vect] = iseven(nums)
    tf_vect = mod(nums, 2) == 0;
    tf_all = all(tf_vect);
end