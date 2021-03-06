function DrawGrapples()

	for player in Client:GetStreamedPlayers() do
	
		local state = player:GetBaseState()
		local lastate = player:GetLeftArmState()
		
		if state == AnimationState.SReelFlight 
		or lastate == AnimationState.LaSGrapple then
			Render:DrawLine(
				player:GetBonePosition("ragdoll_LeftHand"),
				player:GetAimTarget().position,
				Color(60, 60, 60, 255 * math.max(0, 1 - (Vector3.Distance(player:GetPosition(), Camera:GetPosition()) / 1024)))
			)
		end
		
	end
	
end

Events:Subscribe("GameRender", DrawGrapples)
