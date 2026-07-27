puts "**** Arrays & Procedures ****";
array set Mohamed {Waves 70 Electronics 85 Control 65 Comm 78};
array set Ahmed {Waves 66 Electronics 80 Control 88 Comm 69};
array set Mostafa {Waves 72 Electronics 77 Control 70 Comm 88};
proc Avg {Array_Set} {
    upvar $Array_Set local_Array;
    set sum 0.0;
    set local_Array_Names [array names local_Array];
    foreach Element_Name $local_Array_Names {
        set sum [expr $sum + $local_Array($Element_Name)];
    }
    set avg_gpa [expr $sum / [array size local_Array]];
    return $avg_gpa;
}
puts "Mohamed Accumulative GPA is [Avg Mohamed]%";
puts "Ahmed Accumulative GPA is [Avg Ahmed]%";
puts "Mostafa Accumulative GPA is [Avg Mostafa]%";