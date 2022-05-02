//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Village.sol";

interface IVillage {
    struct Attributes{
        uint256  _health;
        uint256  _happiness;
        uint256  _hunger;
        uint256  _population;
        uint256  _buildings;
    }

    function isSet() external view returns (bool);
    
    // getters
    function getAttributes() external view returns (Attributes memory);
    function getHealth() external view returns (uint256);
    function getHappiness() external view returns (uint256);
    function getHunger() external view returns (uint256);
    function getPopulation() external view returns (uint256);
    function getBuildings() external view returns (uint256);
    function getOwner() external view returns (address);
    function getGame() external view returns (address);

    // setters
    function saveAll( uint256 health, uint256 happiness, uint256 hunger, uint256 population, uint256 buildings) external;
    function setHealth(uint256 value) external returns (bool);
    function setHappiness(uint256 value) external returns (bool);
    function setHunger(uint256 value) external returns (bool);
    function setPopulation(uint256 value) external returns (bool);
    function setBuildings(uint256 value) external returns (bool);

}

contract Game {
    // deployer
    address private _creator;
    
    // village owner
    address private _owner;

    // Village class by owner address
    mapping(address => Village) public _villages; 
    mapping(address => bool) public _isCreated; 
    
    // owner address by village address.
    mapping(address => address) public _ownerVillage; //TODO checking village owner

    modifier hasVillage() {
        require(
            !_isCreated[msg.sender],
            "A village already exists for the address"
        );
        _;
    }

    modifier isVillageExists(address sender) {
        require(
            _isCreated[sender],
            "Village not exists"
        );
        _;
    }

    modifier isMax(uint256 value){
        require(value <=100, "Value must be <= 100");
        _;
    }
    

    constructor() {
        _creator = msg.sender;
    }

    function createVillage() public hasVillage returns(Village) {
        // Create new village with default average attributes for:
        // health, happiness, hunger and default summary for population and buildings
        _villages[msg.sender] = new Village(100, 100, 100, 7, 8, true, msg.sender);
        _isCreated[msg.sender] = true;

        //TODO checking village owner
        // village address by owner address
        _ownerVillage[msg.sender] = address(_villages[msg.sender]);
        
        _owner = msg.sender; 
        
        return _villages[msg.sender];
    }

    // getters
    function getOwner(address sender) public isVillageExists(sender) view returns (address){
        return IVillage(address(_villages[sender])).getOwner();
    }

    function getGame(address sender) public isVillageExists(sender) view returns (address){
        return IVillage(address(_villages[sender])).getGame();
    }

     function isSet(address sender) public isVillageExists(sender) view returns (bool) {
        return IVillage(address(_villages[sender])).isSet();
    }

    function getAttributes(address sender) public isVillageExists(sender) view returns (IVillage.Attributes memory){
        return IVillage(address(_villages[sender])).getAttributes();
    }

    function getVillage(address sender) public isVillageExists(sender) view returns (Village) {
        return _villages[sender];
    }

    function getHealth(address sender) public isVillageExists(sender) view returns (uint256) {
        return IVillage(address(_villages[sender])).getHealth();
    }

    function getHappiness(address sender) public isVillageExists(sender) view returns (uint256) {
        return IVillage(address(_villages[sender])).getHappiness();
    }

    function getHunger(address sender) public isVillageExists(sender) view returns (uint256) {
        return IVillage(address(_villages[sender])).getHunger();
    }

    function getPopulation(address sender) public isVillageExists(sender) view returns (uint256) {
        return IVillage(address(_villages[sender])).getPopulation();
    }

      function getBuildings(address sender) public isVillageExists(sender) view returns (uint256) {
        return IVillage(address(_villages[sender])).getBuildings();
    }

    // setters
    function saveGame(uint256 health, uint256 happiness, uint256 hunger, uint256 population, uint256 buildings) public isVillageExists(msg.sender) isMax(health) isMax(happiness) {
        IVillage(address(_villages[msg.sender])).saveAll(health, happiness, hunger, population, buildings);
    }

    function setHealth(uint256 value) external isVillageExists(msg.sender) isMax(value) returns(bool) {
        IVillage(address(_villages[msg.sender])).setHealth(value);

        return true;
    }

    function setHappiness(uint256 value) external isVillageExists(msg.sender) isMax(value) returns(bool) {
        IVillage(address(_villages[msg.sender])).setHappiness(value);

        return true;
    }

    function setHunger(uint256 value) external isVillageExists(msg.sender) isMax(value) returns(bool) {
        IVillage(address(_villages[msg.sender])).setHunger(value);

        return true;
    }

    function setPopulation(uint256 value) external isVillageExists(msg.sender) returns(bool) {
        IVillage(address(_villages[msg.sender])).setPopulation(value);

        return true;
    }

    function setBuildings(uint256 value) external isVillageExists(msg.sender) returns(bool) {
        IVillage(address(_villages[msg.sender])).setBuildings(value);

        return true;
    }

   
}
