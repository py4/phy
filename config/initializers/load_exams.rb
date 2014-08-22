HOLAND = {t1: {}, t2: {}}
lines = File.readlines(Rails.root.join('config/exams/holand/t1'))

q_count = -1
i = 0
q_i = 0

while i < lines.size
	line = lines[i].strip
	if line == '='
		q_i = 0
		q_count += 1
		HOLAND[:t1][q_count] ||= {}
		HOLAND[:t1][q_count][:title] = lines[i+1]
		HOLAND[:t1][q_count][:questions] = {}
		i += 3
	else
		if line.strip == ''
			q_i += 1
		else
			HOLAND[:t1][q_count][:questions][q_i] ||= []
			HOLAND[:t1][q_count][:questions][q_i] << line
		end
		i += 1
	end
end

lines = File.readlines(Rails.root.join('config/exams/holand/t2'))
HOLAND[:t2][:title] = lines[0]
HOLAND[:t2][0] = []
HOLAND[:t2][1] = []
HOLAND[:t2][0] = lines[2..7]
HOLAND[:t2][1] = lines[9..14]

JOBS = {}
lines = File.readlines(Rails.root.join('config/jobs'))
lines.each_with_index { |l,i| lines[i] = l.strip }
i = 0
while i < lines.size
	key, definition,desc, attributes,appro_jobs = lines[i], lines[i+1], lines[i+2], lines[i+3], lines[i+4]
	JOBS[key] ||= {}
	JOBS[key][:definition] = definition
	JOBS[key][:desc] = desc
	JOBS[key][:attributes] = attributes
	JOBS[key][:appro_jobs] = appro_jobs
	i += 6
end