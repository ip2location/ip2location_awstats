#!/usr/bin/perl
#-----------------------------------------------------------------------------
# IP2Location AWStats plugin
# This plugin allow you to get AWStats country report with country name.
#-----------------------------------------------------------------------------
# Perl Required Modules: Geo::IP2Location
#-----------------------------------------------------------------------------

# <-----
# ENTER HERE THE USE COMMAND FOR ALL REQUIRED PERL MODULES
push @INC, "${DIR}/plugins";
if (!eval ('require "Geo/IP2Location.pm";')) { return $@?"Error: $@":"Error: Need Perl module Geo::IP2Location"; }
# ----->
#use strict;
no strict "refs";



#-----------------------------------------------------------------------------
# PLUGIN VARIABLES
#-----------------------------------------------------------------------------
# <-----
# ENTER HERE THE MINIMUM AWSTATS VERSION REQUIRED BY YOUR PLUGIN
# AND THE NAME OF ALL FUNCTIONS THE PLUGIN MANAGE.
my $PluginNeedAWStatsVersion="5.5";
my $PluginHooksFunctions="ShowInfoHost";
# ----->

# <-----
# IF YOUR PLUGIN NEED GLOBAL VARIABLES, THEY MUST BE DECLARED HERE.
use vars qw/
%TmpDomainLookup
$obj
/;
# ----->



#-----------------------------------------------------------------------------
# PLUGIN FUNCTION: Init_pluginname
#-----------------------------------------------------------------------------
sub Init_ip2location {
	my $InitParams=shift;
	my $checkversion=&Check_Plugin_Version($PluginNeedAWStatsVersion);

	# <-----
	# ENTER HERE CODE TO DO INIT PLUGIN ACTIONS
	debug(" Plugin ip2location: InitParams=$InitParams",1);
	my ($datafile,$override)=split(/\s+/,$InitParams,2);

	%TmpDomainLookup=();
	$obj = Geo::IP2Location->open($datafile);
	# ----->

	return ($checkversion?$checkversion:"$PluginHooksFunctions");
}

#-----------------------------------------------------------------------------
# PLUGIN FUNCTION: ShowInfoHost_pluginname
# UNIQUE: NO (Several plugins using this function can be loaded)
# Function called to add additionnal columns to the Hosts report.
# This function is called when building rows of the report (One call for each
# row). So it allows you to add a column in report, for example with code :
#   print "<TD>This is a new cell for $param</TD>";
# Parameters: Host name or ip
#-----------------------------------------------------------------------------
sub ShowInfoHost_ip2location {
    my $param="$_[0]";
	# <-----
	if ($param eq '__title__') {
    	my $NewLinkParams=${QueryString};
    	$NewLinkParams =~ s/(^|&)update(=\w*|$)//i;
    	$NewLinkParams =~ s/(^|&)output(=\w*|$)//i;
    	$NewLinkParams =~ s/(^|&)staticlinks(=\w*|$)//i;
    	$NewLinkParams =~ s/(^|&)framename=[^&]*//i;
    	my $NewLinkTarget='';
    	if ($DetailedReportsOnNewWindows) { $NewLinkTarget=" target=\"awstatsbis\""; }
    	if (($FrameName eq 'mainleft' || $FrameName eq 'mainright') && $DetailedReportsOnNewWindows < 2) {
    		$NewLinkParams.="&framename=mainright";
    		$NewLinkTarget=" target=\"mainright\"";
    	}
    	$NewLinkParams =~ tr/&/&/s; $NewLinkParams =~ s/^&//; $NewLinkParams =~ s/&$//;
    	if ($NewLinkParams) { $NewLinkParams="${NewLinkParams}&"; }

		print "<th width=\"80\">Country</th>";
		print "<th width=\"150\">Region</th>";
		print "<th width=\"150\">City</th>";
		print "<th width=\"150\">ZIP Code</th>";
		print "<th width=\"150\">Time Zone</th>";
	}
	elsif ($param) {
		my $country_long = $obj->get_country_long($param);
		my $region  = $obj->get_region($param);
		my $city = $obj->get_city($param);
		my $zip_code = $obj->get_zipcode($param);
		my $time_zone = $obj->get_timezone($param);

		if ($region =~ /unavailable|supported/) {
			$region = "NA";
		}

		if ($city =~ /unavailable|supported/) {
			$city = "NA";
		}

		if ($zip_code =~ /unavailable|supported/) {
			$zip_code = "NA";
		}

		if ($time_zone =~ /unavailable|supported/) {
			$time_zone = "NA";
		}

		print "<td><span style=\"color: #$color_other\">$country_long</span></td>";
		print "<td><span style=\"color: #$color_other\">$region</span></td>";
		print "<td><span style=\"color: #$color_other\">$city</span></td>";
		print "<td><span style=\"color: #$color_other\">$zip_code</span></td>";
		print "<td><span style=\"color: #$color_other\">$time_zone</span></td>";
	}
	else {
		print "<td>&nbsp;</td>";
	}
	return 1;
	# ----->
}

1;
