package semver

import (
	"regexp"
	"strconv"
)

const semverregex = "^(?P<major>0|[1-9]\\d*)\\.(?P<minor>0|[1-9]\\d*)\\.(?P<patch>0|[1-9]\\d*)"

func Parse(semver string) (map[string]int64, error) {
	regex := regexp.MustCompile(semverregex)
	match := regex.FindStringSubmatch(semver)
	result := make(map[string]int64)

	for i, name := range regex.SubexpNames() {
		if i != 0 && name != "" && match[i] != "" {
			v, err := strconv.ParseInt(match[i], 10, 64)
			if err != nil {
				return nil, err
			}
			result[name] = v
		}
	}
	return result, nil
}
