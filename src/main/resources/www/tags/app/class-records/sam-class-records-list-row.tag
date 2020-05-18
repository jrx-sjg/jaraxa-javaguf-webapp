<sam-class-records-list-row>
	<div class="picture-column"><guf-image class="avatar" imagesrc="{guf.ancestor(this, 'sam-class-records-list-row').pictureUrl}" loadingsrc="{guf.ancestor(this, 'sam-class-records-list-row').defaultPictureUrl}" errorsrc="{guf.ancestor(this, 'sam-class-records-list-row').defaultPictureUrl}" width="70" height="80"></guf-image></div>
	<div class="id-column">{guf.ancestor(this, 'sam-class-records-list-row').classrecords.studentId}</div>
	<div class="student-column flex1">{guf.ancestor(this, 'sam-class-records-list-row').fullName}</div>
	<div class="day-column">
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalAbsences[0]} ( A )</div>
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalLates[0]} ( L )</div>
	</div>
	<div class="day-column">
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalAbsences[1]} ( A )</div>
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalLates[1]} ( L )</div>
	</div>
	<div class="day-column">
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalAbsences[2]} ( A )</div>
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalLates[2]} ( L )</div>
	</div>
	<div class="day-column">
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalAbsences[3]} ( A )</div>
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalLates[3]} ( L )</div>
	</div>
	<div class="day-column">
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalAbsences[4]} ( A )</div>
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalLates[4]} ( L )</div>
	</div>
	<div class="day-column">
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalAbsences[5]} ( A )</div>
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalLates[5]} ( L )</div>
	</div>
	<div class="day-column">
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalAbsences[6]} ( A )</div>
		<div>{guf.ancestor(this, 'sam-class-records-list-row').classrecords.totalLates[6]} ( L )</div>
	</div>
	<style scoped type="dcss">
		:scope {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: horizontal;
			-webkit-flex-direction: row;
			-moz-flex-direction: row;
			-ms-flex-direction: row;
			flex-direction: row;
			height: 80px;
			overflow: hidden;
		}
		:scope > div {
			display: -webkit-box;
			display: -moz-box;
			display: -ms-flexbox;
			display: -webkit-flex;
			display: flex;
			-ms-box-orient: vertical;
			-webkit-flex-direction: column;
			-moz-flex-direction: column;
			-ms-flex-direction: column;
			flex-direction: column;
			justify-content: center;
			font-size: 14px;
		}
		:scope > .picture-column {
			width: 70px;
			border-right: 1px solid @background;
		}
		:scope > .picture-column > guf-image img {
			object-fit: cover;
		}
		:scope > .id-column {
			width: 100px;
			border-right: 1px solid @background;
			margin-left: 16px;
			color: @lighttext;
		}
		:scope > .student-column {
			margin-left: 16px;
			color: @darktext;
		}
		:scope > .day-column {
			width: 70px;
			border-left: 1px solid @background;
			align-items: center;
			color: @lighttext;
		}
	</style>
	<script type="text/javascript">
		var tag = this;

		tag.mdlClasses = {};
		tag.defaultDcss = {
			"primary": "@primary",
			"background": "@background",
			"darktext": "@darktext",
			"lighttext": "@lighttext",
			"lines": "@lines"
		};
		tag.mixin('mdl');
		tag.preferredName = tag.classrecords.studentPreferredName || tag.classrecords.studentFirstName;
		tag.fullName = tag.classrecords.studentLastName + " " + tag.classrecords.studentFirstName;
		tag.defaultPictureUrl = "./img/default.png";
		tag.pictureUrl = tag.classrecords.picture ? app.getBaseUrl() + tag.classrecords.picture : tag.defaultPictureUrl;

	</script>
</sam-class-records-list-row>