def assert_works_like_an_entity_repo_that_belongs_to_team_with_date(entity_class:, entity_repo_factory: -> {})
  describe "Repo For Entities That Belong To Teams" do
    context "Given entities for different teams" do
      before do
        entity_repo.save(team_1_entity)
        entity_repo.save(team_2_entity)
        entity_repo.save(tomorrow_entity)
      end

      it "should fetch those entities by team" do
        entitys_for_team_1 = entity_repo.all_by_team_id_and_date(1, today)

        expect(entitys_for_team_1).to include team_1_entity
        expect(entitys_for_team_1).not_to include team_2_entity
      end

      it "should fetch those entities by date" do
        entities_for_today = entity_repo.all_by_team_id_and_date(1, today)
        expect(entities_for_today).to include team_1_entity
        expect(entities_for_today).not_to include tomorrow_entity
      end
    end

    let(:today) { Date.new(2011,4,4) }
    let(:tomorrow) { Date.new(2011,4,5) }
    let(:team_1_entity) { entity_class.new(team_id: 1, date: today) }
    let(:team_2_entity) { entity_class.new(team_id: 2, date: today) }
    let(:tomorrow_entity) { entity_class.new(team_id: 1, date: tomorrow) }
    let(:entity_repo) { entity_repo_factory.call }
  end
end
