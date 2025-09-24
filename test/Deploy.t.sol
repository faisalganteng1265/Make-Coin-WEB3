pragma solidity ^0.8.13;
import {Test, console} from "forge-std/Test.sol";
import {TokenScript}from "script/Token.s.sol";
import {Token} from "src/Token.sol";

contract DeployTest is Test {
    TokenScript script;
    Token token;

    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    address deployer = vm.addr(deployerPrivateKey);

    function setUp() public {
        script = new TokenScript();
    
    }
    function testDeploy() public {
        address tokenAddress = script.run();
        assertEq(Token(tokenAddress).owner(), deployer);
        console.log("Deployer address:", deployer);
}
}