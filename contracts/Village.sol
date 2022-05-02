//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Village {
    address private _game;

    address private _owner;

    bool private _set;

    // Average village atributes for health, happiness, hunger and default summary values for population and buildings
    struct Attributes {
        uint256  _health;
        uint256  _happiness;
        uint256  _hunger;
        uint256  _population;
        uint256  _buildings;
    
    }
    
    Attributes attributes;

    modifier isGame() {
        require(msg.sender == _game, "Request did not come from the game");
        _;
    }

    constructor(
        uint256 health,
        uint256 happiness,
        uint256 hunger,
        uint256 population,
        uint256 buildings,
        bool set,
        address owner
    ) {
        // msg.sender is main Game contract address
        _game = msg.sender;
        
        // user address owner
        _owner = owner;
        _set = set;

        attributes = Attributes(health, happiness, hunger, population, buildings);
    }

    // Getters
    function getAttributes() external view returns (Attributes memory){
        return attributes;
    }

    function getHealth() external view returns (uint256) {
        return attributes._health;
    }

    function getHappiness() external view returns (uint256) {
        return attributes._happiness;
    }

    function getHunger() external view returns (uint256) {
        return attributes._hunger;
    }

    function getPopulation() external view returns (uint256) {
        return attributes._population;
    }

    function getBuildings() external view returns (uint256) {
        return attributes._buildings;
    }

    function isSet() external view returns (bool) {
        return _set;
    }

    function getOwner() external view returns (address){
        return _owner;
    }

    function getGame() external view returns (address){
        return _game;
    }

    // Setters
    function saveAll(
        uint256 health,
        uint256 happiness,
        uint256 hunger,
        uint256 population,
        uint256 buildings
    ) public isGame{
        attributes._health = health;
        attributes._happiness = happiness;
        attributes._hunger = hunger;
        attributes._population = population;
        attributes._buildings = buildings;
    }

    function setHealth(uint256 value) external isGame returns(bool) {
        attributes._health = value;
        return true;
    }

    function setHappiness(uint256 value) external isGame returns(bool) {
        attributes._happiness = value;
        return true;
    }

     function setHunger(uint256 value) external isGame returns(bool) {
        attributes._hunger = value;
        return true;
    }

    function setPopulation(uint256 value) external isGame returns(bool) {
        attributes._population = value;
        return true;
    }

    function setBuildings(uint256 value) external isGame returns(bool) {
        attributes._buildings = value;
        return true;
    }
}
