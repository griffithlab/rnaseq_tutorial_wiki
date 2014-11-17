#!/usr/bin/perl

use strict;
use warnings;

use Cwd qw/getcwd abs_path/;
use File::Basename;
use IO::File;

my $full_path = abs_path($0) ."\n";

my ($basename, $dirname, $suffix) = File::Basename::fileparse($full_path,qw/\.pl/);
$dirname =~ s/bin\///;
print $dirname ."\n";
my $toc_file = $dirname .'/Home.md';
my $toc_fh = IO::File->new($toc_file,'r');

my $sh_fh = IO::File->new('tutorial.sh','w');
my $module_header;
while (my $toc_line = $toc_fh->getline) {
    if ($toc_line =~ /^\d+\.\s+\*\*(.*)\*\*/) {
        $module_header = $1;
        print $sh_fh '# '. $module_header ."\n\n";
    }
    if ($toc_line =~ /^\s+\d+\.\s+\[\[(.*)\|(.*)\]\]/) {
        my $section_header = $1;
        my $section_file = $dirname .'/'. $2 .'.md';
        
        print $sh_fh '## '. $section_header ."\n\n";
        my $section_fh = IO::File->new($section_file,'r');
        while (my $section_line = $section_fh->getline() ) {
            if ($section_line =~ /^\s+/) {
                print $sh_fh $section_line;
            } else {
                print $sh_fh '### '. $section_line;
            }
        }
    }
}

exit;
