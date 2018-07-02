--[[
    File: Player.lua
    Author: Sam Triest

    The Player class defines the blueprint for the player's ship,
    and its operations.
]]

Player =
{
    lives,
    score,
    mesh,
    position,
    rotation,
    rotationSpeed,
    velocity,
    direction,
    friction,
    speed,
    speedCutoff,
    collisionRadius
}

--[[
    The vertices that make up the player's ship.
]]
local vertices =
{
    {-25, -15, 1, 1, 255, 255, 255, 255},
    { 25,   0, 1, 1, 255, 255, 255, 255},
    {-25,  15, 1, 1, 255, 255, 255, 255}
}

--[[
    Creates and returns a new Player object.
]]
function Player:New(x, y)
    player = {}
    setmetatable(player, self)
    self.__index = self

    player.lives = 3
    player.score = 0
    player.scoreTier = 1

    player.invulnerable = false
    -- Maximum time the player can be invulnerable, in seconds
    player.invulnerableDuration = 1.5
    -- Invulnerability time remaining, in seconds
    player.invulnerableTimer = player.invulnerableDuration
    -- If hide is true, don't render the player
    player.hide = false

    -- The time it takes the player to teleport to a random new location, in seconds
    player.teleportDuration = 0.5
    -- Keeps track of the time remaining on the current teleport, in seconds
    player.teleportTimer = player.teleportDuration
    -- Whether the player is currently teleporting
    player.teleporting = false

    player.mesh = love.graphics.newMesh(vertices, "fan", "dynamic")

    if x == nil or y == nil then
        x = love.graphics.getWidth() / 2
        y = love.graphics.getHeight() / 2
    end
    player.position = Vector2:New(x, y)
    player.velocity = Vector2:New()
    player.direction = Vector2:New()

    player.rotation = 0
    player.rotationSpeed = 3

    player.friction = 0.15
    player.speed = 500
    player.speedCutoff = 0.0005

    player.collisionRadius = 25

    player.timeSinceLastShot = 0
    player.shotCooldown = 0.1

    player.debugColour = { 0, 0, 0, 0 }

    return player
end

--[[
    Moves the player's ship.
]]
function Player:Update(dt)
    -- Normalise looking direction
    self.direction = Vector2:New(math.cos(self.rotation), math.sin(self.rotation))
    self.direction:Normalise()

    if love.keyboard.isDown("left") then
        self.rotation = self.rotation - self.rotationSpeed * dt
    elseif love.keyboard.isDown("right") then
        self.rotation = self.rotation + self.rotationSpeed * dt
    end

    -- Increase velocity while up arrow is down
    if love.keyboard.isDown("up") then
        self.velocity.x = self.velocity.x + self.direction.x * dt
        self.velocity.y = self.velocity.y + self.direction.y * dt
    else
        if self.velocity:Length() > 0 then
            -- If the ship is moving slower than the cutoff speed, stop moving
            if self.velocity:Length() < self.speedCutoff then
                self.velocity.x = 0
                self.velocity.y = 0

            -- Ship is above the cutoff speed with no user input
            -- Apply friction
            else
                normalised = Normalise(self.velocity)
                normalised.x = normalised.x * self.friction * dt
                normalised.y = normalised.y * self.friction * dt

                self.velocity.x = self.velocity.x - normalised.x
                self.velocity.y = self.velocity.y - normalised.y
            end
        end
    end

    -- Speed limit
    if self.velocity:Length() > 1 then
        self.velocity:Normalise()
    end

    -- Update ship position
    self.position.x = self.position.x + self.velocity.x * self.speed * dt
    self.position.y = self.position.y + self.velocity.y * self.speed * dt

    -- Wrap to the other side of the screen if the player moves past the screen edge
    if self.position.x < -25 then
	self.position.x = WINDOW_W
    elseif self.position.x > WINDOW_W + 25 then
	self.position.x = -25
    end
    if self.position.y < -25 then
	self.position.y = WINDOW_H
    elseif self.position.y > WINDOW_H + 25 then
	self.position.y = -25
    end

    -- Ensure the player cannot instantly lose to an asteroid at the respawn point
    if self.invulnerable then
        self.invulnerableTimer = self.invulnerableTimer - dt

        -- Blink the player's ship to give a visual cue it is invulnerable
        if self.invulnerableTimer % 0.2 < 0.1 then
            self.hide = true
        else
            self.hide = false
        end

        if self.invulnerableTimer < 0 then
            self.invulnerable = false
            self.invulnerableTimer = self.invulnerableDuration
        end
    end

    -- Let the player teleport to a random location
    if love.keyboard.isDown("lctrl") then
        self.teleporting = true
        self.invulnerable = true
    end
    -- Hide the player while teleporting
    if self.teleporting then
        self.hide = true
        self.teleportTimer = self.teleportTimer - dt

        -- Give the ship a random new location and set its velocity to zero
        if self.teleportTimer <= 0 then
            self.position = Vector2:New(math.random(0, WINDOW_W), math.random(0, WINDOW_H))
            self.velocity = Vector2:New()
            self.teleporting = false
            self.hide = false
            self.invulnerable = false
            self.teleportTimer = self.teleportDuration
        end
    end
end

--[[
    Instantiates a new Projectile object at the player's position, in the
    direction the player is aiming, if the shot cooldown has elapsed and
    the spacebar is down.
]]
function Player:Shoot(dt)
    -- Update the timer every tick
    self.timeSinceLastShot = self.timeSinceLastShot + dt

    if not love.keyboard.isDown("space") then
        return
    end

    if self.timeSinceLastShot < self.shotCooldown then
        -- Still on cooldown
        return
    end

    -- Reset the cooldown and fire the projectile
    self.timeSinceLastShot = 0
    position = Vector2:New(self.position.x, self.position.y)
    direction = Vector2:New(self.direction.x, self.direction.y)
    direction:Normalise()
    Projectile:New(position, direction)
end

--[[
    Sets up circle-to-circle collision settings for the player's ship.
    This will hopefully be replaced with a more precise system at a later date.
]]
function Player:CircleCollisionSetup(collisionRadius)
    self.collisionRadius = collisionRadius
end

--[[
    Renders the Player to the screen. Call this method in love.draw().
    If debugging is enabled, draw a circle around the player that
    represents the collision radius.
]]
function Player:Render(debug)
    if self.hide then
        return
    end

    love.graphics.draw(self.mesh, self.position.x, self.position.y, self.rotation,
                       1, 1, 0, 0)

    if not debug then
        return
    end

    r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(self.debugColour)
    love.graphics.circle("line", self.position.x, self.position.y, self.collisionRadius)
    love.graphics.setColor(r, g, b, a)
end

--[[
    Increases the player's score after shooting an asteroid.
]]
function Player:IncreaseScore(value)
    self.score = self.score + value

    -- Give the player an additional life for every 10000 points scored
    if self.score > (self.scoreTier * 10000) then
        self.lives = self.lives + 1
        self.scoreTier = self.scoreTier + 1
    end
end

--[[
    Renders the player's score to the screen at the specified location.
    This function should be called in love.draw().
]]
function Player:RenderScore(font, x, y)
    love.graphics.setFont(font)
    love.graphics.printf("Score: " .. self.score, x, y, 200)
end

--[[
    Renders the number of remaining lives the player has at the specified
    location. This function should be called in love.draw().
]]
function Player:RenderLives(font, x, y)
    love.graphics.setFont(font)
    love.graphics.printf("Lives: " .. self.lives, x, y, 200)
end

--[[
    This method gets called whenever the player collides with an asteroid.
]]
function Player:Collided()
    self.lives = self.lives - 1
    self.invulnerable = true

    if self.lives < 1 then
        -- Game over
        LoadScene(3)
    end

    -- Reset movement and respawn the player in the middle of the screen
    self.velocity = Vector2:New()
    self.position = Vector2:New(WINDOW_W / 2, WINDOW_H / 2)
end

