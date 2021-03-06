class 'cLootbox'

function cLootbox:__init(args)

    self.uid = args.uid
    self.position = args.position
    self.angle = args.angle
    self.tier = args.tier
    self.model_data = args.model_data
    self.static_objects = {}
    self.contents = {}

    self:CreateModel()

end

function cLootbox:Remove()

    for _, obj in pairs(self.static_objects) do
        if IsValid(obj) then 
            obj:Remove()
        end
    end

end

function cLootbox:CreateModel()

    local position = self.position + self.model_data.offset

    if self.model_data.offset2 then
        position = position + self.angle * self.model_data.offset2
    end

    table.insert(self.static_objects, 
        ClientStaticObject.Create({
            position = position,
            angle = self.angle,
            model = self.model_data.model,
            collision = self.model_data.col
        }))

    if self.model_data.top_model then

        table.insert(self.static_objects, 
            ClientStaticObject.Create({
                position = position,
                angle = self.angle,
                model = self.model_data.top_model,
                collision = self.model_data.top_col
            }))

    end

    if self.model_data.model2 then

        table.insert(self.static_objects, 
            ClientStaticObject.Create({
                position = self.position - Vector3(0, 1, 0) + self.model_data.offset,
                angle = self.angle,
                model = self.model_data.model2
            }))

    end

    -- Enable outlines
    for _, obj in pairs(self.static_objects) do
        --obj:SetOutlineColor(Color(255,255,255,100))
        --obj:SetOutlineEnabled(true)

        -- Register static object ids in uid lookup table
        LootManager.SO_id_to_uid[obj:GetId()] = self.uid
    end


end