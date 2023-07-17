//It is one of the Leetcode challange I had solved.

// Write a function to find the longest common prefix string amongst an array of strings.

// If there is no common prefix, return an empty string "".


var longestCommonPrefix = function (strs) {
	let primaryIndex = 0;
	let resultString = '';

	//If the Array has only one Element
	if (strs.length < 2) return strs[0];

	//If the first element's value is "" then there is no logic to go ahed
	if (strs[0].length == 0) return "";

	//Loop through the Array
	while (primaryIndex < strs[0].length) {
		let isCommon = true;
		let isShort = true;
		for (let i = 0; i < strs.length; i++) {
			//If the letter is not same as the Indexed letter then we have found our Coomon prefix
			if (strs[i][primaryIndex] !== strs[0][primaryIndex]) {
				isCommon = false;
				break;
			}
			if (primaryIndex < strs[i].length) {
				isShort = false;
			}
			//  console.log(strs[0][primaryIndex]);
		}
		if (primaryIndex == strs[0].length - 1 && isCommon) {
			return strs[0];
		}
		if (isCommon) {
			//   console.log(primaryIndex);
			resultString = resultString + strs[0][primaryIndex];
			primaryIndex++;
		} else {
			return resultString;
		}
		if (isShort) {
			return resultString;
		}
	}

};

