require_relative '../package_installer'

describe 'package_installer' do
	let(:packages1) { ['KittenService: CamelCaser', 'CamelCaser: '] }
	let(:packages2) { ['KittenService: ','Leetmeme: Cyberportal','Cyberportal: Ice','CamelCaser: KittenService','Fraudstream: Leetmeme','Ice: '] }

	describe 'format_array' do
		it 'should return an array containing packages and dependencies as inner arrays' do
			expect(format_input(packages1)).to eq([['KittenService', 'CamelCaser'], ['CamelCaser']])
		end
	end
end

