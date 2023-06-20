<?php
function quarterlySchedule($rule)
{
	$userDateTime = gmdate('Y-m-d H:i:s');
	$lastDayOfMonth = date('t', strtotime($userDateTime));
	$dayOfMonth = ($rule['dayOfMonth'] > $lastDayOfMonth ? $lastDayOfMonth : $rule['dayOfMonth']);
	$currentYear = date('Y', strtotime($userDateTime));

	// determine the months it's supposed to run, based on the starting month
	$rule['startMonth'] = str_pad($rule['startMonth'], 2, '0', STR_PAD_LEFT);
	$firstRun = date("Y-{$rule['startMonth']}-{$dayOfMonth} {$rule['timeOfDay']}", strtotime($userDateTime));
	$secondRun = date("{$currentYear}-m-d {$rule['timeOfDay']}", strtotime('+3 months', strtotime($firstRun)));
	$thirdRun = date("{$currentYear}-m-d {$rule['timeOfDay']}", strtotime('+3 months', strtotime($secondRun)));
	$fourthRun = date("{$currentYear}-m-d {$rule['timeOfDay']}", strtotime('+3 months', strtotime($thirdRun)));

	$possibleRuns = array($firstRun, $secondRun, $thirdRun, $fourthRun);

	// sort the possible runs in order (start month might be a later month than the current actual month)
	usort($possibleRuns, function ($a, $b) {
		return strtotime($a) - strtotime($b);
	});

	//Filter out only the run times that are after the current user time
	$filteredPossibleRuns = array_values(array_filter($possibleRuns, function ($date) use ($userDateTime) {
		return strtotime($date) >= strtotime($userDateTime);
	}));
}
