classdef Filling
    properties (Constant, Hidden)
        water_kgm3 = 997;
        crumb_kgm3 = 1400;
        sand_kgm3 = 1680;
    end

    methods (Static)
        function frac = ball(diam_in, wgt_lb, den_kgm3)
            frac = filler.ballm(diam_in*0.0254, wgt_lb*0.4536, den_kgm3);
        end
        function fill_frac = ballm(diam_m, wgt_kg, den_kgm3)
            ball_vol = Sphere(diam_m).vol;
            fill_vol = wgt_kg / den_kgm3;
            fill_frac = fill_vol / ball_vol;
            Warn.warnIf(fill_frac > 1, "filler:overfull", "ball is filled beyond capacity")
        end
        
        function len_in = pipe(diam_in, wgt_lb, den_kgm3, fill_frac)
            len_m = filler.pipem(diam_in*0.0254, wgt_lb*0.4536, den_kgm3, fill_frac);
            len_in = len_m/0.0254;
        end
        function len_m = pipem(diam_m, wgt_kg, den_kgm3, fill_frac)
            vol_m3 = wgt_kg / den_kgm3;
            fill_m = vol_m3 / ((diam_m/2)^2*pi);
            len_m = fill_m / fill_frac;
        end
    end
end