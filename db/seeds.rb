Exam.destroy_all
Dir.foreach('config/exams') do |item|
	next if item == '.' or item == '..'
	lines = File.readlines('config/exams/'+item)
	special = lines[2].strip
	exam = Exam.create name: lines[0].strip, special: special
	choice_count = lines[1].split(',').size
	lines[1].split(',').each do |choice|
		exam.choices.create content: choice.strip
	end
	index = 3
	while index < lines.size
		content = lines[index].strip
		mask = ""
		if special == "true"
			lines[index+1..(index+choice_count)].each { |m| mask += m.strip }
			mask += "-#{lines[index+choice_count+1].strip}-"
			lines[index+choice_count+2..index+2*choice_count+1].each { |m| mask += m.strip }
			index += 2*choice_count+2
		else
			lines[index+1..index+choice_count].each { |m| mask += m.strip }
			index += choice_count + 1
		end

		exam.questions.create content: content, mask: mask
	end

end

Task.destroy_all

TASKS = ['اضافه کردن کد کاربری داوطلب',
	'فعال کردن فرم اطلاعات اولیه شامل مصاحبه و فیزیک',
	'پر شدن فرم اطلاعات اولیه توسط داوطلب',
	'فعال کردن موردی آزمون‌های شناختی',
	'پرشدن آزمون‌های شناختی توسط داوطلب',
	'فعال کردن موردی آزمون‌های عاطلب و هیجانی',
	'پرشدن آزمون‌های عاطفی و هیجانی توسط داوطلب'
]

TASKS.each do |task|
	Task.create title: task
end
