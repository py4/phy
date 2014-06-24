Exam.destroy_all
Dir.foreach('config/exams') do |item|
	next if item == '.' or item == '..'
	lines = File.readlines('config/exams/'+item)
	exam = Exam.create name: lines[0].strip
	lines[1].split(',').each do |choice|
		exam.choices.create content: choice.strip
	end
	lines[2..-1].each do |question|
		exam.questions.create content: question.strip
	end
end

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
