/*
    Copyright 2017 Phillip A. Elsasser

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/
pragma solidity 0.4.18;

// TODO BUILD TEST!
/// @title Math function library with overflow protection inspired by Open Zeppelin
library MathLib {

    int256 constant INT256_MIN = int256((uint256(1) << 255));
    int256 constant INT256_MAX = int256(~((uint256(1) << 255)));

    function multiply(uint256 a, uint256 b) pure internal returns (uint256) {
        uint256 c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function subtract(uint256 a, uint256 b) pure internal returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) pure internal returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    /// @notice safely adds to signed integers ensuring that no wrap occurs
    /// @param a
    /// @param b
    function add(int256 a, int256 b) pure internal returns (int256) {
        int256 c = a + b;
        if(!isSameSign(a, b)) { // result will always be smaller than current value, no wrap possible
            return c;
        }

        if(a >= 0) { // a is positive, b must be less than MAX - a to prevent wrap
            assert(b <= INT256_MAX - a);
        } else { // a is negative, b must be greater than MIN - a to prevent wrap
            assert(b >= INT256_MIN - a);
        }
        return c;
    }

    /// @param a integer to determine sign of
    /// @return int8 sign of original value, either +1,0,-1
    function sign(int a) pure internal returns (int8) {
        if(a > 0) {
            return 1;
        } else if (a < 0) {
            return -1;
        }
        return 0;
    }

    /// @param a integer to compare to b
    /// @param b integer to compare to a
    /// @return bool true if a and b are the same sign (+/-)
    function isSameSign(int a, int b) pure internal returns (bool) {
        return ( a == b || a * b > 0);
    }

    /// @param a integer to determine absolute value of
    /// @return uint non signed representation of a
    function abs(int a) pure internal returns (uint) {
        if(a < 0) {
            return uint(-a);
        }
        else {
            return uint(a);
        }
    }


}
